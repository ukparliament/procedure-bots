class TweatyTwackerController < ApplicationController

  def index
  
    # We get all the treaties.
    @instruments = Treaty.all.order( 'created_at DESC' )
    
    # We set the page meta information.
    @page_title = "Tweaty Twacker"
    @description = "Treaties laid under the Constitutional Reform and Governance Act 2010."
    @rss_url = tweaty_twacker_list_url( :format => 'rss' )
    @crumb << { label: @page_title, url: nil }
    @section = 'tweaty-twacker'
    @subsection = 'all'
  end

  def not_posted_to_bluesky
  
    # We get all the treaties not posted to Bluesky.
    @instruments = Treaty.all.order( 'created_at DESC' ).where( 'posted_to_bluesky IS FALSE' )
    
    # We set the page meta information.
    @page_title = "Tweaty Twacker - not posted to Bluesky"
    @description = "Treaties laid under the Constitutional Reform and Governance Act 2010 not posted to Bluesky."
    @crumb << { label: "Tweaty Twacker", url: tweaty_twacker_list_url }
    @crumb << { label: 'Not posted to Bluesky', url: nil }
    @section = 'tweaty-twacker'
    @subsection = 'not-bluesky'
    
    render :template => 'tweaty_twacker/index'
  end

  def not_posted_to_mastodon
  
    # We get all the treaties not posted to Mastodon.
    @instruments = Treaty.all.order( 'created_at DESC' ).where( 'posted_to_mastodon IS FALSE' )
    
    # We set the page meta information.
    @page_title = "Tweaty Twacker - not posted to Mastodon"
    @description = "Treaties laid under the Constitutional Reform and Governance Act 2010 not posted to Mastodon."
    @crumb << { label: "Tweaty Twacker", url: tweaty_twacker_list_url }
    @crumb << { label: 'Not posted to Mastodon', url: nil }
    @section = 'tweaty-twacker'
    @subsection = 'not-mastodon'
    
    render :template => 'tweaty_twacker/index'
  end
end
