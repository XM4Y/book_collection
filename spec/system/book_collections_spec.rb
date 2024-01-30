require 'rails_helper'

RSpec.describe "BookCollections", type: :system do
  before do
    driven_by(:rack_test)
  end

describe 'validations' do
    it 'is valid with valid attributes' do
      book = Book.new(
        title: 'Example Book',
        author: 'Alex Mayer',
        price: 9.99,
        published_date: Date.today
      )
      expect(book).to be_valid
    end

it 'not valid without title' do
    book = Book.new(title: '')
    expect(book).not_to be_valid
end

it 'not valid without author' do
  book = Book.new(title: 'Example Book', price: 9.99, published_date: Date.today)
  expect(book).not_to be_valid
  expect(book.errors[:author]).to include("can't be blank")
end

it 'not valid without price' do
  book = Book.new(title: 'Example Book', author: 'Alex Mayer', published_date: Date.today)
  expect(book).not_to be_valid
  expect(book.errors[:price]).to include("can't be blank")
end

it 'not valid without published_date' do
  book = Book.new(title: 'Example Book', author: 'Alex Mayer', price: 9.99)
  expect(book).not_to be_valid
  expect(book.errors[:published_date]).to include("can't be blank")
end

end

describe "BookCollections", type: :request do
    describe 'POST /books' do
      it 'creates a new book and displays appropriate flash notice' do
        post '/books', params: {
          book: {
            title: 'Example Book',
            author: 'Alex Mayer',
            price: 9.99,
            published_date: Date.today
          }
        }
  
        expect(response).to redirect_to(book_path(Book.last))
        follow_redirect!
  
        expect(response.body).to include('Book was successfully created.')
      end
    end
end



end
