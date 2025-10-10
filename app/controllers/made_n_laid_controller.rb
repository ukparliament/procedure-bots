class MadeNLaidController < ApplicationController

  def index
  
    # We get all the made and laid statutory instruments.
    @instruments = MadeNLaidStatutoryInstrument.all.order( 'created_at DESC' )
    
    # We set the page meta information.
    @page_title = "Made 'n' Laid"
    @description = "Statutory instruments made as laid."
    @rss_url = made_n_laid_list_url( :format => 'rss' )
    @crumb << { label: @page_title, url: nil }
    @section = 'made-n-laid'
    @subsection = 'all'
  end

  def not_posted_to_bluesky
  
    # We get all the made and laid statutory instruments not posted to Bluesky.
    @instruments = MadeNLaidStatutoryInstrument.all.order( 'created_at DESC' ).where( 'posted_to_bluesky IS FALSE' )
    
    # We set the page meta information.
    @page_title = "Made 'n' Laid - not posted to Bluesky"
    @description = "Statutory instruments made as laid not posted to Bluesky."
    @crumb << { label: "Made 'n' Laid", url: made_n_laid_list_url }
    @crumb << { label: 'Not posted to Bluesky', url: nil }
    @section = 'made-n-laid'
    @subsection = 'not-bluesky'
    
    render :template => 'made_n_laid/index'
  end

  def not_posted_to_mastodon
  
    # We get all the made and laid statutory instruments not posted to Mastodon.
    @instruments = MadeNLaidStatutoryInstrument.all.order( 'created_at DESC' ).where( 'posted_to_mastodon IS FALSE' )
    
    # We set the page meta information.
    @page_title = "Made 'n' Laid - not posted to Mastodon"
    @description = "Statutory instruments made as laid not posted to Mastodon."
    @crumb << { label: "Made 'n' Laid", url: made_n_laid_list_url }
    @crumb << { label: 'Not posted to Mastodon', url: nil }
    @section = 'made-n-laid'
    @subsection = 'not-mastodon'
    
    render :template => 'made_n_laid/index'
  end
end
