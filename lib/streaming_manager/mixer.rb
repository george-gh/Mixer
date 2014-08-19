class StreamingManager::Mixer

  FEED_NAME = "feed1.ffm"
  FFSERVER_CONF_PATH = "/etc/ffserver.conf"
  OUTPUT_STREAM_NAME = "live.flv"

  # Initialize OutputMixer with Video, Audio and Overlay objects
  def initialize _video = nil, _audio = nil, _overlay = nil
    @video = _video
    @audio = _audio
    @overlay = _overlay
    # @configuration = load_configuration
    # @output = create_output_object
  end

  # Push output stream
  def push_stream
    launch_ffserver
    kill_ffplay
    kill_ffmpeg
    # apply_overlay
    # apply_audio
    generate_stream
  end

  # private

  # Load configuration params from ffserver.conf file
  def load_configuration
    # TODO
  end

  # Create OutputStream object
  def create_output_object
    OutputStream.new(@video, @audio, @overlay)
  end

  # Check if ffserver is running, otherwise it launchs the service
  def launch_ffserver
    rr = %x[ps -C ffserver -o pid h]
    return unless rr.blank?
    command = "nohup ffserver -f #{FFSERVER_CONF_PATH} &"
    spawn(command)
    return
  end
 
  # Kill ffserver processes on system
  def kill_ffserver
    kill_process "ffserver"
  end

  # Kill ffmpeg processes
  def kill_ffmpeg
    kill_process "ffpmeg"
  end

  # Kill ffplay processes
  def kill_ffplay
    kill_process "ffplay"
  end

  # Kill process by name
  def kill_process _name
    rr = %x[ps -C #{_name} -o pid h]
    unless rr.blank?
      process_ids = rr.split("\n").map{|el| el.to_i}
      process_ids.each{|pid| Process.kill :SIGTERM, pid}
    end
  end

  # Set overlay to the stream
  def apply_overlay
    # TODO
    # @output.set_overlay
  end

  # Set audio to the stream
  def apply_audio
    # TODO
    # @output.set_audio
  end

  # Create an ffserver.conf file with tech specs for the stream
  def create_ffserver_configuration
    # TODO
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

end
