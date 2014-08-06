# Call external api to retrive json data to build channels availables
class StreamingManager::ChannelManager

  # Get json 
  def get_channels ch_arr
    # channels_hash = retrieve_external_data json_hash
    channels = build_channels ch_arr
    return channels
  end

  # private

  # Receive json file, parse it and return a data hash
  # Temp: using local json file, we need to call an external url
  def retrieve_external_data pure_json
    # pure_json = get_json_data
    data_hash = JSON.parse pure_json
    data_hash
  end

  # Retrieve json data from yml configuration file
  def get_json_data
    config_file = "#{Rails.root}/config/streaming_channels.yml"
    return {} unless File.exists? config_file
    ff = YAML::load_file config_file
    url = ff["channels_url"]
    response = Net::HTTP.get_response(URI.parse(url))
    return response.body
  rescue Exception => ex
    return ""
  end

  # Create Channel objects from data hash
  def build_channels ch_arr
    return [] if ch_arr.blank?
    channels = []
    ch_arr.each do |channel_hash|
      ch = Channel.new(url: channel_hash["url"], type: channel_hash["type"])
      channels << ch
    end
    return channels
  end


end
