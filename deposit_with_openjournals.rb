require "faraday"
require "theoj"

issue_id = ENV["ISSUE_ID"]
paper_path = ENV["PAPER_PATH"].to_s
journal_url = "#{ENV['JOURNAL_URL']}/papers/api_deposit",
journal_secret = ENV['JOURNAL_SECRET']

paper = Theoj::Paper.new()
if paper_path.empty?
  issue = Theoj::ReviewIssue.new(issue_id)
else
  paper = Theoj::Paper.new("", "", paper_path)
end



parameters = { id: issue_id
               #metadata: Base64.encode64(deposit_payload.to_json),
               #doi: formatted_doi,
               #archive_doi: archive_doi,
               #citation_string: citation_string,
               title: paper.title,
               secret: journal_secret
              }

deposit_call = Faraday.post(url, parameters.to_json, {})
if deposit_call.status.between?(200, 299)
  system("echo 'Journal responded. Deposit looks good'")
else
  raise "!! ERROR: Something went wrong with this deposit when calling #{journal_url}"
end
