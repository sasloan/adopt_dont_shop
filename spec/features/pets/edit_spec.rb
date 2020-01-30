require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I go to a dogs show page and click Update Pet' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: 80003)
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", approximate_age: 6, sex: "Female")
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", approximate_age: 4, sex: "Male")
		end

		it 'I am directed to a form to update my dogs infromation' do

			visit "/pets/#{@jona.id}"

			expect(page).to have_css("img[src*='#{@jona.image}']")
			expect(page).to have_content(@jona.name)
			expect(page).to have_content(@jona.approximate_age)
			expect(page).to have_content(@jona.sex)
			expect(page).to have_content("This pet is available to adopt")

			expect(current_path).to eq("/pets/#{@jona.id}")

			expect(page).to have_link("Update Pet")

			click_on "Update Pet"

			expect(current_path).to eq("/pets/#{@jona.id}/edit")

			expect(page).to have_content("Image")
			expect(page).to have_content("Name")
			expect(page).to have_content("Description")
			expect(page).to have_content("Approximate age")
			expect(page).to have_content("Sex")

			fill_in :image, with: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg"
			fill_in :name, with: "New Jona"
			fill_in :description, with: "Pretty Shepherd"
			fill_in :approximate_age, with: 9
			fill_in :sex, with: "Female"

			click_on "Submit"

			expect(current_path).to eq("/pets/#{@jona.id}")

			expect(page).to have_css("img[src*='https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg']")
			expect(page).to have_content("New Jona")
			expect(page).to have_content("Pretty Shepherd")
			expect(page).to have_content(9)
			expect(page).to have_content("This pet is available to adopt")
		end
	end
end