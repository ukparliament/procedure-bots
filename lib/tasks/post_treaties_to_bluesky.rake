require 'net/http'
require 'json'

# ## A task to post treaties to bluesky.
task :post_treaties_to_bluesky => :environment do
  puts "posting treaties to bluesky"
  
  # We find any treaties that have not been posted to Bluesky.
  unposted = Treaty.where( 'posted_to_bluesky IS FALSE' )
  puts "Attempting to post #{unposted.count} treaties to bluesky"
  
  # For each unposted treaty ...
  unposted.each do |treaty|
  
    # We get the bluesky handle and password.
    bluesky_handle = ENV['TWEATY_TWACKER_BLUESKY_HANDLE']
    bluesky_app_password = ENV['TWEATY_TWACKER_BLUESKY_APP_PASSWORD']
    
    
    # We construct the text to be posted.
    post_text = treaty.post_text
    
    # We attempt to authenticate.
    uri = URI( 'https://bsky.social/xrpc/com.atproto.server.createSession' )
    body = { "identifier": bluesky_handle, "password": bluesky_app_password }
    headers = { 'Content-Type': 'application/json' }
    response = Net::HTTP.post( uri, body.to_json, headers )
  
    # We grab the access tokens from the JSON response.
    access_jwt = JSON.parse( response.body )['accessJwt']
    did = JSON.parse( response.body )['did']
  
    # We construct the link facets.
    facets = create_facets( post_text )
    
    # We construct the post.
    post = {
        "$type": "app.bsky.feed.post",
        "text": post_text,
        "createdAt": Time.now.iso8601,
        "facets": facets,
    }
    
    # We construct the body.
    body = {
      "repo": did,
      "collection": "app.bsky.feed.post",
      "record": post,
    }
  
    # We convert the body to JSON.
    body = body.to_json

    # We attempt to post.
    uri = URI( 'https://bsky.social/xrpc/com.atproto.repo.createRecord' )
    headers = { 'Content-Type': 'application/json', 'Authorization': "Bearer #{access_jwt}" }
    response = Net::HTTP.post( uri, body, headers )
  
    # If the request is successful ...
    if response.code == '200'
    
      # ... we mark the treaty as posted to Bluesky.
      treaty.posted_to_bluesky = true
      treaty.save!
    else
    
      puts '======'
      puts "Failed to post: #{post_text}"
      puts "Post length: #{post_text.size}"
      puts response.inspect
    end
  
    # We pause for two seconds.
    sleep( 2 )
  end
end


# ## A method to construct the link facet for Bluesky.
# [ATProtocol documentation](https://atproto.com/blog/create-post#mentions-and-links)
# [Code copied and adapted from GitHub](https://github.com/ShreyanJain9/bskyrb/issues/3)
def create_facets( text )
  
  # We create an array to hold the facets.
  facets = []

  # We define the regex pattern to match a link.
  link_pattern = URI.regexp

  # We find the links.
  text.enum_for( :scan, link_pattern ).each do |m|
  
    # link_pattern was picking up on anything with a colon, so we check the first item in the array is https
    if m.first == 'https'
      index_start = Regexp.last_match.offset(0).first
      index_end = Regexp.last_match.offset(0).last
      facets.push(
        '$type' => 'app.bsky.richtext.facet',
        'index' => {
          'byteStart' => index_start,
          'byteEnd' => index_end,
        },
        'features' => [
          {
            '$type' => 'app.bsky.richtext.facet#link',
            'uri' => m.join("").strip.sub( 'httpsa', 'https://a' ) # this is the matched link
          },
        ],
      )
    end
  end
  
  # We return the matched facets.
  facets
end



