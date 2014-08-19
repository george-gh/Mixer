class ChannelsController < ApplicationController

  # include ActionController::Live

  skip_before_filter :verify_authenticity_token, only: :create_channels
  before_action :load_values, only: [ :preview, :output ]
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
    # values initialized by before_action callback
  end
  
  # Return video streaming output, with selected channel and possible overlay
  def output_stream
    # response.headers['Content-Type'] = 'video/x-la-asf'
    response.headers['Content-Type'] = 'text/event-stream'
    20.times {
      response.stream.write "VideoAssemblea - Test"
    }
  ensure
    response.stream.close
  end

  # Using ffserver, ffmpeg e ffplay, send the single channel stream via url
  def output
    video_name = params["video"]
    video = @videos.select{|e| e.name.eql? video_name}
    overlay_name = params["overlay"]
    overlay = @overlays.select{|e| e.name.eql? overlay_name}
    audio_name = params["audio"]
    audio = @audios.select{|e| e.name.eql? audio_name}
    @mixer = StreamingManager::Mixer.new(video, overlay, audio)
    @mixer.push_stream
    render nothing: true
  end

  private

  def load_values
    @manager = StreamingManager::ChannelManager.new
    @channels = @manager.get_channels
    @videos = @channels.select{|ch| ch.type.eql?"video"}
    @overlays = @channels.select{|ch| ch.type.eql?"image"}
    @audios = @channels.select{|ch| ch.type.eql?"audio"}
  end

  def channels_params
    params.require(:channels).permit( :url, :type )
  end

end
