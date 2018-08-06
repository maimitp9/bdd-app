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

Given("I have a book in my inventory") do
  FactoryBot.create(:book, :user => @registered_user, :name => 'React.js', :author => 'Diyu')
end

When("I change the title of my book") do
  visit root_path

  click_link 'Edit'

  fill_in 'book_name', with: 'Star Wars'

  click_button 'Update Book'
end

Then("I should see the book with the new title in my inventory") do
  visit root_path

  expect(page).to_not have_content('React.js')
  expect(page).to have_content('Diyu')
end

When("I remove a book from my inventory") do
  visit root_path
  click_link 'Destroy'
end

Then("I should not see it listing in the inventory anymore") do
  expect(page).to_not have_content('React.js')
end

