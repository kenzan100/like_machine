class ArticleUrlValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    validate_url
  end

  def validate_url
    uri = URI.parse(@record.url)
    if !uri.kind_of?(URI::HTTP)
      raise URI::InvalidURIError
    end
  rescue URI::InvalidURIError
    @record.errors[:base] << "URL you entered isn't valid"
  end
end
