# Releasing

As the gem is a dependency in a number of services we build and deploy it to [Rubygems](https://rubygems.org/gems/os_map_ref) so we can properly version it, and the dependent services can manage which versions they take.

This means as changes are made, we will also need to update the version of the gem published to Rubygems. The following outlines the steps to take.

## Decide on the version

Assuming changes have been made to the project, the first step is deciding when to cut a new release. This will determine the version number assigned because as best as we can, we try to follow [Semver](https://semver.org/).

Essentially

- breaking changes to the API should result in a **MAJOR** version change
- adding new functionality, major changes to dependencies, or large scale housekeeping overhauls should result in a **MINOR** version change
- fixes, minor changes to dependencies, and minor housekeeping tasks should result in a **PATCH** version change

## Update version.rb

Update `lib/os_map_ref/version.rb` to match the version number you intend to release with.

```ruby
module OsMapRef
  VERSION = "0.5.0"
end
```

Commit the change and push to **main**. We don't create a PR for this as we rely on PR's to provide the content for our [CHANGELOG](CHANGELOG.md), so this would just make for a redundant entry.

## Tag the repo

Assuming that has built successfully in Travis, then tag the repo and push the new tag

```bash
git tag -a v0.5.0 -m "Version 0.5.0"
git push origin v0.5.0
```

[Travis-CI](https://travis-ci.org/DEFRA/os-map-ref) is automatically configured to build and deploy the updated gem to Rubygems when it sees a new tag pushed. It will only succeed though if the new version does not match one that has already been published to Rubygems.

Hence it's important to update the `version.rb` before creating and pushing the new tag.

## Update CHANGELOG

With the new version published we can update the [CHANGELOG](CHANGELOG.md). This is automatically done via a rake task.

```bash
bundle exec rake changelog
```

Commit the changes to `CHANGELOG.md` and push to **main**. Again like the version change we don't create a PR for this as we don't want PR's for updating the CHANGELOG becoming noise in its content.

## Publish release

In GitHub select the releases page for the project, then click 'Draft a new release'. Select the version tag we've just released, leave target as **main**, and set the release title as **Version #.#.#**. In the description simply copy the content from the CHANGELOG for the release.

```markdown
# v0.5.0 (2018-12-28)

[Full changelog](https://github.com/DEFRA/os-map-ref/blob/main/CHANGELOG.md#v050-2018-12-28)

## Merged pull requests:

- Update travis config to enable auto deployments #22 (Cruikshanks)
- Update to match latest CI conventions #21 (Cruikshanks)
- Update changelog for 0.4.2 release #20 (Cruikshanks)
```

Save the changes and you're done.
