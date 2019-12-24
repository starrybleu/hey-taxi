module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def content_type_json_header
    { 'Content-type': 'application/json'}
  end
end