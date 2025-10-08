# ## A task to import treaties.
task :import_treaties => :environment do
  puts "importing treaties"
  
  # We include the SPARQL response module.
  include Sparql::Response
  
  # We get the treaty query.
  request_body = treaty_query
  
  # We get the SPARQL response as a CSV.
  csv = get_sparql_response_as_csv( request_body )

  # For each row in the CSV ...
  csv.each do |row|
  
    # ... we store the URI of the treaty.
    uri = row['Treaty']
    
    # We attempt to find a Treaty with this URI ...
    treaty = Treaty.find_by_uri( uri )
    
    # Unless we find the treaty ...
    unless treaty
    
      # ... we create a a new treaty object.
      puts "Creating treaty: #{row['treatyTitle']}"
      treaty = Treaty.new
      treaty.uri = row['Treaty']
      treaty.title = row['treatyTitle']
      treaty.lead_organisation_name = row['LeadOrg']
      treaty.series_citation = row['seriesCitation']
      treaty.laid_on = row['laidDate']
      treaty.procedure_browser_url = row['WorkPackageURL']
      treaty.save!
    end
  end
end


# A query to get treaties.
def treaty_query
  "
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX : <https://id.parliament.uk/schema/>
    PREFIX id: <https://id.parliament.uk/>
    SELECT ?Treaty ?treatyTitle ?LeadOrg ?seriesCitation ?laidDate ?WorkPackageURL  WHERE {
     ?Treaty a :Treaty;
             :name ?treatyTitle ;
             :treatyHasLeadGovernmentOrganisation ?LeadOrg;
             :workPackagedThingHasWorkPackage ?workPackage;
             :treatyHasSeriesMembership ?series;
             :laidThingHasLaying ?laying.
     ?LeadOrg :name ?LeadOrgName.
     ?series :seriesItemCitation ?seriesCitation.
     ?laying :date ?laidDate.
      ?laying :businessItemHasProcedureStep id:cspzmb6w.  
      BIND(STR(?workPackage) AS ?workPackageStr)
      BIND(REPLACE(?workPackageStr, '^.*[/#]', '') AS ?workPackageID)
      BIND(CONCAT('https://api.parliament.uk/procedure-browser/work-packages/', ?workPackageID) AS ?WorkPackageURL)
    } order by desc(?laidDate)
  "
end