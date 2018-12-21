require "application_system_test_case"

class ToolsTest < ApplicationSystemTestCase
  setup do
    @tool = tools(:one)
  end

  test "visiting the index" do
    visit tools_url
    assert_selector "h1", text: "Tools"
  end

  test "creating a Tool" do
    visit tools_url
    click_on "New Tool"

    fill_in "Deleted", with: @tool.deleted
    fill_in "Description", with: @tool.description
    fill_in "Featured", with: @tool.featured
    fill_in "Links", with: @tool.links
    fill_in "Name", with: @tool.name
    fill_in "Published", with: @tool.published
    fill_in "Published at", with: @tool.published_at
    fill_in "Slug", with: @tool.slug
    click_on "Create Tool"

    assert_text "Tool was successfully created"
    click_on "Back"
  end

  test "updating a Tool" do
    visit tools_url
    click_on "Edit", match: :first

    fill_in "Deleted", with: @tool.deleted
    fill_in "Description", with: @tool.description
    fill_in "Featured", with: @tool.featured
    fill_in "Links", with: @tool.links
    fill_in "Name", with: @tool.name
    fill_in "Published", with: @tool.published
    fill_in "Published at", with: @tool.published_at
    fill_in "Slug", with: @tool.slug
    click_on "Update Tool"

    assert_text "Tool was successfully updated"
    click_on "Back"
  end

  test "destroying a Tool" do
    visit tools_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tool was successfully destroyed"
  end
end
