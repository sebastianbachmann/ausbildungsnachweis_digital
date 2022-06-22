require "test_helper"
require "controllers/api/test"

class Api::V1::ActivityReportsEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @activity_report = create(:activity_report, team: @team)
      @other_activity_reports = create_list(:activity_report, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(activity_report_data)
      # Fetch the activity_report in question and prepare to compare it's attributes.
      activity_report = ActivityReport.find(activity_report_data["id"])

      assert_equal activity_report_data['title'], activity_report.title
      assert_equal activity_report_data['place_of_training'], activity_report.place_of_training
      assert_equal activity_report_data['duration_of_work'], activity_report.duration_of_work
      assert_equal activity_report_data['apprentice_firstname'], activity_report.apprentice_firstname
      assert_equal activity_report_data['apprentice_lastname'], activity_report.apprentice_lastname
      assert_equal activity_report_data['year_of_training'], activity_report.year_of_training
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal activity_report_data["team_id"], activity_report.team_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/teams/#{@team.id}/activity_reports", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      activity_report_ids_returned = response.parsed_body.dig("data").map { |activity_report| activity_report.dig("attributes", "id") }
      assert_includes(activity_report_ids_returned, @activity_report.id)

      # But not returning other people's resources.
      assert_not_includes(activity_report_ids_returned, @other_activity_reports[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/activity_reports/#{@activity_report.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/activity_reports/#{@activity_report.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      activity_report_data = Api::V1::ActivityReportSerializer.new(build(:activity_report, team: nil)).serializable_hash.dig(:data, :attributes)
      activity_report_data.except!(:id, :team_id, :created_at, :updated_at)

      post "/api/v1/teams/#{@team.id}/activity_reports",
        params: activity_report_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/teams/#{@team.id}/activity_reports",
        params: activity_report_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/activity_reports/#{@activity_report.id}", params: {
        access_token: access_token,
        title: 'Alternative String Value',
        duration_of_work: 'Alternative String Value',
        apprentice_firstname: 'Alternative String Value',
        apprentice_lastname: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @activity_report.reload
      assert_equal @activity_report.title, 'Alternative String Value'
      assert_equal @activity_report.duration_of_work, 'Alternative String Value'
      assert_equal @activity_report.apprentice_firstname, 'Alternative String Value'
      assert_equal @activity_report.apprentice_lastname, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/activity_reports/#{@activity_report.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("ActivityReport.count", -1) do
        delete "/api/v1/activity_reports/#{@activity_report.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/activity_reports/#{@activity_report.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
