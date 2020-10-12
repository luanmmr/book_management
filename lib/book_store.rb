require 'yaml/store'

class BookStore

  def initialize(file_name)
    @store = YAML::Store.new(file_name)
  end

  def all
    @store.transaction do
      @store.roots.map { |key| @store[key] }
    end
  end

  def save(params)
    book = Book.new(title: params['title'], description: params['description'],
                    year: params['year'].to_i, author: params['author'],
                    pages: params['pages'].to_i)
    @store.transaction do
      highest_id = @store.roots.max || 0
      book.id = highest_id + 1
      @store[book.id] = book
    end
  end

  def find(key)
    @store.transaction do
      @store[key]
    end
  end

  def update(key, params)
    @store.transaction do
      @store[key].title = params['title']
      @store[key].description = params['description']
      @store[key].year = params['year'].to_i
      @store[key].author = params['author']
      @store[key].status = params['status']
      @store[key].pages = params['pages'].to_i
    end
  end

  def save_comment(params)
    @store.transaction do
      @store[params['id'].to_i].set_comments(params['page'].to_i,
                                             params['comment'])
    end
  end

  def update_comment(params)
    @store.transaction do
      @store[params['id'].to_i].set_comments(params['page'].to_i,
                                             params['comment'])
    end
  end

end
