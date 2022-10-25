require "theoj"

issue_id = ENV["ISSUE_ID"]
paper_path = ENV["PAPER_PATH"].to_s
journal_alias = ENV['JOURNAL_ALIAS']
journal_secret = ENV['JOURNAL_SECRET']

journal = Theoj::Journal.new(Theoj::JOURNALS_DATA[journal_alias.to_sym])
issue = Theoj::ReviewIssue.new(journal.data[:reviews_repository], issue_id)
issue.paper = Theoj::Paper.new("", "", paper_path) unless paper_path.empty?

submission = Theoj::Submission.new(journal, issue, issue.paper)

deposit_call = submission.deposit!(journal_secret)

if deposit_call.status.between?(200, 299)
  system("echo 'Journal responded. Deposit looks good'")
  system("echo 'paper_doi=#{submission.paper_doi}' >> $GITHUB_OUTPUT")
else
  system("echo 'CUSTOM_ERROR=Could not deposit with Open Journals.' >> $GITHUB_ENV")
  raise "!! ERROR: Something went wrong with this deposit when calling #{journal.data[:deposit_url]}"
end
