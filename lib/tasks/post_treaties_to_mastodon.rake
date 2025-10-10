require 'net/http'
require 'json'
require 'uri'


task :post_treaties_to_mastodon => :environment do
  puts "posting treaties to mastodon"
  
  # We set up the authentication token.
  bearer_token = ENV['TWEATY_TWACKER_BEARER_TOKEN']
  
  # We find any treaties that have not been posted to Mastodon.
  unposted = Treaty.where( 'posted_to_mastodon IS FALSE' )
  puts "Attempting to post #{unposted.count} treaties to mastodon"
  
  # For each unposted treaty ...
  unposted.each do |treaty|
  
    # ... we construct the text to be posted.
    post_text = treaty.post_text
    
    # We encode the post text.
    parser = URI::Parser.new
    post_text = parser.escape( post_text )
    
    # We construct the URI.
    uri = URI( "https://mastodon.me.uk/api/v1/statuses?status=#{post_text}" )
    
    # We create the client.
    http = Net::HTTP.new( uri.host, uri.port )
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # We create  the request.
    request =  Net::HTTP::Post.new( uri )
  
    # We add headers to the request.
    request.add_field "Authorization", "Bearer #{bearer_token}"

    # We make the request.
    request = http.request( request )
    
    # If the request is successful ...
    if request.code == '200'

      # ... we record that the treaty has been posted.
      treaty.posted_to_mastodon = true
      treaty.save!
    else
    
      puts '======'
      puts "Failed to post: #{post_text}"
      puts "Post length: #{post_text.size}"
      puts request.inspect
    end
    
    # We pause for two seconds.
    sleep( 2 )
  end
end