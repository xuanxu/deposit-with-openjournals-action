# Open Journals :: Deposit with Open Journals

This action deposit an accepted paper with Open Journals

## Usage

Usually this action is used as a step in a workflow after the paper's pdf and xml files are already accepted into the papers repository.

### Inputs

The action accepts the following inputs:

- **journal_alias**: Required. The alias of the Open Journal to deposit with
- **journal_secret**: Required. The access token to be used to post the paper payload
- **issue_id**: Required. The issue number of the submission in the reviews repository
- **paper_path**: Required. The complete filepath of the paper.md file

### Outputs

- **paper_doi**: The DOI for the accepted paper

### Example

Use it adding it as a step in a workflow `.yml` file in your repo's `.github/workflows/` directory and passing your custom input values.

```yaml
on:
  workflow_dispatch:
   inputs:
      issue_id:
        description: 'The issue number of the submission'
jobs:
  processing:
    runs-on: ubuntu-latest
    steps:
      - name: Deposit with Open Journals
        uses: xuanxu/deposit-with-openjournals-action@main
        with:
          journal_url: https://joss.theoj.org/
          journal_secret: ${{ secrets.JOURNAL_SECRET }}
          issue_id: ${{ github.event.inputs.issue_id }}
          paper_path: ./docs/paper.md
```
