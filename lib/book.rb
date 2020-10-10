class Book
  attr_accessor :title, :description, :year, :author, :id, :registration_date,
                :reading_start_date, :reading_end_date, :pages
  attr_reader :status, :page_comments

  def initialize(title:, description:, year:, author:, pages:)
    self.title = title
    self.description = description
    self.year = year
    self.author = author
    self.status = 'not read'
    self.registration_date = Time.now
    self.pages = pages
    @page_comments = []
  end

  def set_comments(page, comment)
    page_comments[page] = comment
  end

  def status=(sts)
    if status == "read"
      self.reading_end_date = ''
    end
    @status = sts
    modifyStatus
  end

  def modifyStatus
    if status == 'reading'
      self.reading_start_date = Time.now
    elsif status == 'read'
      self.reading_end_date = Time.now
    end
  end

end
