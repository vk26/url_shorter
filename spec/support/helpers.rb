def resp_body
  JSON.parse response.body
end

def resp_data
  resp_body['data']
end

def resp_data_attrs
  resp_data['attributes']
end

def resp_errors
  resp_body['errors']
end


