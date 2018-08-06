require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { instance_double(User) }

  before { log_in(user) }

  describe "GET #index" do
    let(:books) { [
      instance_double(Book),
      instance_double(Book)
    ] }

    before do
      allow(user).to receive(:books).and_return(books)
      get :index
    end

    it "looks up all books that belongs to current user" do
      expect(assigns(:books)).to eq(books)
    end
  end

  describe 'POST #create' do
    let(:book) { FactoryBot.build_stubbed(:book) }
    let(:params) { { name: 'Test', authod: 'Sonu' } }

    before do
      allow(:book).to receive(:save)
      allow(:user).to receive_message_chain(:book, :build).and_return(book)
    end

    it 'saves the book' do
      post :create, params: { book: params }
      expect(:book).to have_received(:save)
    end

    context 'when the book is succesfully saved' do
      before do
        allow(book).to receive(:save).and_return(true)
        post :create, :params => { :book => params }
      end

      it 'redirects to the book show page' do
        expect(response).to redirect_to(book_path(book))
      end

      it 'redirects to the book show page' do
        expect(flash[:notice]).to eq('Book was successfully created.')
      end
    end

    context 'when the book can’t be saved' do
      before do
        allow(book).to receive(:save).and_return(false)
        post :create, :params => { :book => params }
      end

      it 'redirects back to the new page' do
        expect(response).to render_template(:new)
      end
    end

  end
end