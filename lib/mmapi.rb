require 'open-uri'
require 'json'

class MovieAPI

  API_URL = 'http://mymovieapi.com/'

  # Queries the API for an IMDB ID
  # 
  # @param [String] id A Movie IMDB ID
  # 
  # @param [Hash] options The options to create a search query
  # @todo  fill out these docs
  # 
  # @return [Hash] Returns a single movie hash
  def self.search_by_id(id, options = {})
    return self.request("#{API_URL}?id=#{URI::encode(id)}" + self.parameterize(options))
  end

  # Queries the API for a movie title
  # 
  # @param [String] title The title of the movie
  # 
  # @param [Hash] options The options to create a search query
  # @option options [Integer] :year (2013) The year you wish to search for - defaults to current year
  # @option options [Integer] :yg (0) When this paramter is 0, the year parameter is disabled
  # @option options [String] :mt ('none') The movie type you wish to search for
  # @option options [String] :plot ('simple') The plot type you with the API to return
  # @option options [Integer] :episode (1) When the parameter is 0, "episodes" is not included in the result
  # @option options [Integer] :offset (0) Paging offset
  # @option options [Integer] :limit (1) The maximum number of records to return
  # @option options [String] :lang ('en-US') The data language you wish to return
  # @option options [String] :aka ('simple') The aka type you with to return
  # @option options [String] :release ('simple') The release date type you with to return
  # @option options [Integer] :business (0) Include the business field
  # @option options [Integer] :tech (0) Include the technical field
  #
  # @return [Array] Returns an array of hashes.
  def self.search_by_title(title, options = {})
    return self.request("#{API_URL}?q=#{URI::encode(title)}" + self.parameterize(options))
  end

  private

    # @private
    # @param [Hash] options Query options
    # @return [String] URL encoded string of params
    def self.parameterize(options)
      return options ? options.collect {|key, value| "#{key}=#{URI::encode(value)}"}.join('&') : ''
    end

    # @private
    # @param [String] uri
    # @return [Hash] Movie hash
    # @return [Array] Array of movie hashes
    def self.request(uri)
      response = open(uri).read
      data = JSON.parse(response)
      return data
    end

end