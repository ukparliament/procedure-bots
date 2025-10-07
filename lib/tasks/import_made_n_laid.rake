# ## A task to import made and laid statutory instruments.
task :import_made_n_laid => :environment do
  puts "importing made and laid statutory instruments"
  
  # We include the SPARQL response module.
  include Sparql::Response
  
  # We get the made n laid query.
  request_body = made_n_laid_query
  
  # We get the SPARQL response as a CSV.
  csv = get_sparql_response_as_csv( request_body )

  # For each row in the CSV ...
  csv.each do |row|
  
    # ... we store the URI of the instrument.
    uri = row['MadeSI']
    
    # We attempt to find a made and laid statutory instrument with this URI ...
    made_n_laid_statutory_instrument = MadeNLaidStatutoryInstrument.find_by_uri( uri )
    
    # Unless we find the made and laid statutory instrument ...
    unless made_n_laid_statutory_instrument
    
      # ... we create a a new made-n-laid-statutory-instrument object.
      puts "Creating made and laid statutory instrument: #{row['Title']}"
      made_n_laid_statutory_instrument = MadeNLaidStatutoryInstrument.new
      made_n_laid_statutory_instrument.uri = row['MadeSI']
      made_n_laid_statutory_instrument.title = row['Title']
      made_n_laid_statutory_instrument.made_on = row['MadeDate']
      made_n_laid_statutory_instrument.laid_on = row['laidDate']
      made_n_laid_statutory_instrument.procedure = row['ProcedureName']
      made_n_laid_statutory_instrument.procedure_browser_url = row['WorkPackageURL']
      made_n_laid_statutory_instrument.save!
    end
  end
end


# A query to get made and laid statutory instruments.
def made_n_laid_query
  "
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX : <https://id.parliament.uk/schema/>
    PREFIX id: <https://id.parliament.uk/>

    SELECT ?MadeSI ?Title ?MadeDate ?laidDate ?ProcedureName ?WorkPackageURL WHERE {
      ?MadeSI a :MadeStatutoryInstrumentPaper;
              :workPackagedThingName ?Title;
              :statutoryInstrumentPaperMadeDate ?MadeDate;
              :laidThingHasLaying ?laying;
              :workPackagedThingHasWorkPackage ?workPackage.
      ?laying :date ?laidDate.
      ?laying :businessItemHasProcedureStep id:cspzmb6w. 
      ?workPackage :workPackageHasProcedure ?procedure.
      ?procedure :name ?ProcedureName.

      BIND(STR(?workPackage) AS ?workPackageStr)
      BIND(REPLACE(?workPackageStr, '^.*[/#]', '') AS ?workPackageID)
      BIND(CONCAT('https://api.parliament.uk/procedure-browser/work-packages/', ?workPackageID) AS ?WorkPackageURL)
    }
    ORDER BY DESC(?MadeDate)
  "
end