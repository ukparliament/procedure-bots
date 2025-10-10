xml.item do
  xml.guid( instrument.uri )
  xml.title( instrument.title )
  xml.description( "#{instrument.series_citation}, led by the #{instrument.lead_organisation_name}" )
  xml.link( instrument.procedure_browser_url )
  xml.pubDate( instrument.laid_on.rfc822 )
end