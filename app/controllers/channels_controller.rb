class ChannelsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: :create_channels
  layout 'channel'

  # Show all channels availables
  def index
    manager = StreamingManager::ChannelManager.new
    @channels = manager.get_channels
  end

  # POST with json channels object
  def create_channels
    # Obtain an array of hashes
    channels_arr = params["channels"]
    manager = StreamingManager::ChannelManager.new
    @channels = manager.channels_list channels_arr
    redirect_to channels_path
  end

  # Video channels preview
  def preview
    manager = StreamingManager::ChannelManager.new
    @channels = manager.get_channels
    @videos = @channels.select{|ch| ch.type.eql?"video"}
    @overlays = @channels.select{|ch| ch.type.eql?"image"}
  end

  private

  def channels_params
    params.require(:channels).permit( :url, :type )
  end

end
