require 'sinatra'
require 'book_store'
require 'book'

store = BookStore.new('books.yml')

get('/') do
  erb :index
end

get('/books') do
  @books = store.all
  erb :books
end

get('/books/new') do
  erb :new
end

post('/books/create') do
  store.save(params)
  redirect '/books'
end

get('/books/:id') do
  id = params['id'].to_i
  @book = store.find(id)
  erb :show
end

get('/books/edit/:id') do
  @book = store.find(params['id'].to_i)
  erb :edit
end

post('/books/update/:id') do
  store.update(params['id'].to_i, params)
  redirect "/books/#{params['id']}"
end

post('/books/comments/:id') do
  store.save_comment(params)
  redirect '/books'
end

get('/books/:id/comments') do
  @book = store.find(params['id'].to_i)
  erb :comments
end
