xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
  xml.channel do
    xml.title(  @page_title )
    xml.description( @description )
    xml.link( tweaty_twacker_list_url )
    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
    xml.language( 'en-uk' )
    xml.managingEditor( 'somervillea@parliament.uk (Anya Somerville)' )
    xml.pubDate( @instruments.first.laid_on.rfc822 ) unless @instruments.empty?
    xml.tag!( 'atom:link', { :href => tweaty_twacker_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
    xml << render(:partial => 'tweaty_twacker/instrument', :collection => @instruments ) unless @instruments.empty?
  end
end