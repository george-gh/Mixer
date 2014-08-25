# Class for output stream object
# It needs almost a video stream
class OutputStream

  include ActiveModel::Model
  extend ActiveModel::Naming

  FEED_NAME = "feed1.ffm"
  OUTPUT_STREAM_NAME = "live.flv"

  # Create object
  def initialize _video = nil, _audio = nil, _overlay = nil
    @video = _video
    @audio = _audio
    @overlay = _overlay
  end

  # Streaming url
  def url
    "http://localhost:8090/live.flv"
  end

  # Using ffmpeg command, create the ffm stream for ffserver
  def create_ffm_stream
    return false if @video.blank?
    cmd = "ffmpeg -i #{@video.url} -vcodec copy http://localhost:8090/#{FEED_NAME} &"
    spawn(cmd)
  # rescue Exception => ex
  #   return ex.message
  end

  # Launch ffplay command to stream output
  def generate_stream
    create_ffm_stream
    # try to delete next row
    sleep 3
    cmd = "ffplay http://localhost:8090/#{OUTPUT_STREAM_NAME} &"
    spawn(cmd)
  # rescue Exception => ex
  #   return ex.message
  end

  # Set overlay
  def set_overlay
    # TODO
  end

  # Set audio
  def set_audio
    # TODO
  end

end
