# Class for output stream object
# It needs almost a video stream
class OutputStream

  include ActiveModel::Model
  extend ActiveModel::Naming

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


end
