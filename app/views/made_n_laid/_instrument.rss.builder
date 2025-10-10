xml.item do
  xml.guid( instrument.uri )
  xml.title( instrument.title )
  xml.link( instrument.procedure_browser_url )
  xml.pubDate( instrument.laid_on.rfc822 )
end