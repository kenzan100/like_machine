class ArticleUrlValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    validate_url
  end

  def validate_url
    uri = URI.parse(@record.url)
    uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    @record.errors[:base] << "URL you entered isn't valid"
  end
end
