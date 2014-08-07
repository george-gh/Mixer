# Call external api to retrive json data to build channels availables
class StreamingManager::ChannelManager

  # Process an http POST with json data and return a channels array
  def channels_list ch_arr
    channels = build_channels ch_arr
    return channels
  end 

  # Process an HTTP GET and return a channels array 
  def get_channels
    data_hash = retrieve_external_data
    channels_hash = data_hash["channels"] 
    channels = build_channels channels_hash
    return channels
  end

  # Return streamID value from json
  def get_session
    channels_hash = retrieve_external_data
    return channels_hash["streamID"]
  end

  # private

  # Receive json file, parse it and return a data hash
  def retrieve_external_data
    # pure_json = get_json_data
    # I'm using a json file only for testing
    pure_json = File.read("#{Rails.root}/streaming.json")
    # ------------------------------------
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
      ch = Channel.new(url: channel_hash["url"].to_s, type: channel_hash["type"].to_s)
      channels << ch
    end
    return channels
  end


end
