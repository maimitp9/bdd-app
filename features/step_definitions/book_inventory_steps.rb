Given("I have populated my inventory with several books") do
  FactoryBot.create(:book,
                    :user => @registered_user,
                    :name => "React.js",
                    :author => "Maimit Patel")
  FactoryBot.create(:book,
                    :user => @registered_user,
                    :name => "Art Galary",
                    :author => "Divya Patel")
end

Then("I should see the list of my books") do
  expect(page).to have_content('React.js')
  expect(page).to have_content('Art Galary')
end

When("I submit a new book to my inventory") do
  click_link "New Book"

  fill_in 'book_name', with: 'Redux'
  fill_in 'book_author', with: 'Pihu Patel'

  click_button 'Create Book'
end

Then("I should see the new book in my inventory") do
  visit root_path

  expect(page).to have_content('Redux')
  expect(page).to have_content('Pihu Patel')
end
