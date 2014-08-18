class StreamingManager::OutputMixer

  FEED_NAME = "feed1.ffm"
  FFSERVER_CONF_PATH = "/etc/ffserver.conf"
  OUTPUT_STREAM_NAME = "live.flv"

  # Initialize OutputMixer with Video, Audio and Overlay objects
  def initialize _video = nil, _audio = nil, _overlay = nil
    @video = _video
    @audio = _audio
    @overlay = _overlay
    # load_configuration
  end

  # Push output stream
  def push_stream
    launch_ffserver
    # apply_overlay
    # apply_audio
    generate_stream
  end

  # private

  # Load configuration params from ffserver.conf file
  def load_configuration
    # TODO
  end

  # Check if ffserver is running, otherwise it launchs the service
  def launch_ffserver
    rr = %x[ps aux | grep ffserv]
    return if rr.include?"ffserver"
    command = "nohup ffserver -f /etc/ffserver.conf &"
    spawn(command)
    return
  end

  # Check if ffserver is running, otherwise it launchs the service
  def launch_ffserver
    rr = %x[ps aux | grep ffserv]
    return if rr.include?"ffserver"
    command = "nohup ffserver -f #{FFSERVER_CONF_PATH} &"
    spawn(command)
    return
  end

  # Set overlay to the stream
  def apply_overlay
    # TODO
  end

  # Set audio to the stream
  def apply_audio
    # TODO
  end

  # Using ffmpeg command, create the ffm stream for ffserver
  def create_ffm_stream
    return false if @video.blank?
    cmd = "ffmpeg -i #{@video.url} -vcodec copy http://localhost:8090/#{FEED_NAME}"
    spawn(cmd)
  # rescue Exception => ex
  #   return ex.message
  end

  # Launch ffplay command to stream output
  def generate_stream
    create_ffm_stream
    cmd = "ffplay http://localhost:8090/#{OUTPUT_STREAM_NAME}"
    spawn(cmd)
  # rescue Exception => ex
  #   return ex.message
  end

end
