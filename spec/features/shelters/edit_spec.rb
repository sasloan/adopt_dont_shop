require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I visit a shelters show page' do
		before :each do
			@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: "80221")

			visit "/shelters/#{@acph.id}"
		end

		it 'I see a link to update the shelters information' do

			expect(current_path).to eq("/shelters/#{@acph.id}")

			expect(page).to have_link("Update Shelter")

			click_on "Update Shelter"

			expect(current_path).to eq("/shelters/#{@acph.id}/edit")

			expect(page).to have_content("Name")
			expect(page).to have_content("Address")
			expect(page).to have_content("City")
			expect(page).to have_content("State")
			expect(page).to have_content("Zip")

			fill_in :name, with: "Adams Pet Hospital"
			fill_in :address, with: "232 120th ave."
			fill_in :city, with: "Westminster"
			fill_in :state, with: "Colorado"
			fill_in :zip, with: "80233"

			click_on "Update Shelter"

			expect(current_path).to eq("/shelters/#{@acph.id}")

			expect(page).to have_content("Adams Pet Hospital")
			expect(page).to have_content("232 120th ave.")
			expect(page).to have_content("Westminster")
			expect(page).to have_content("Colorado")
			expect(page).to have_content("80233")

			expect(page).not_to have_content("Adams County Pet Hospital")
			expect(page).not_to have_content("7834 Pecos St.")
			expect(page).not_to have_content("Thornton")
			expect(page).not_to have_content("Co.")
			expect(page).not_to have_content("80221")
		end
	end
end
