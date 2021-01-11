# Génération de badge

## Pour infection

> Pour les version d'infection >= 0.17

Fichier `.gitlab-ci.yml` :

```yaml
# This file is paste in each MS, added from filesGeneralPathCopy.php

stages:
  - test
  - badge

job_infection:
  stage: test
  image: myself/php-tools:ci
  tags:
    - docker
  script:
      - php docker/php/set_database.php test
      - php bin/phpunit --filter=testToInstallPhpUnitBin
      - infection --min-msi=$CI_INFECTION_MIN_MSI --min-covered-msi=$CI_INFECTION_MIN_COVERED_MSI --threads=$(nproc)
  allow_failure: false
  only:
    refs:
      - branches
  except:
    variables:
      - $CI_RUN_INFECTION == "false" # Set in GitLab: Settings > CI/CD > Variables
  artifacts:
    when: always
    paths:
      - infection-log.json
    expire_in: 30 min

job_infection_badge:
  stage: badge
  image: python:3.9
  tags:
    - docker
  allow_failure: true
  needs:
    - job:infection
  before_script:
    - echo "Python other dependencies installation"
    - pip3 install anybadge
    - apt update -y
    - apt install -y jq bc
  script:
    - mkdir badges
    - cd badges
    - mutation_msi=$(cat ../infection-log.json | jq .stats.msi)
    - anybadge -l "Mutation MSI" -v $mutation_msi -f mutation_msi.svg 50=red 90=yellow
    - mutation_mcc=$(cat ../infection-log.json | jq .stats.mutationCodeCoverage)
    - anybadge -l "Mutation MCC" -v $mutation_mcc -f mutation_mcc.svg 50=red 90=yellow
    - mutation_ccmsi=$(cat ../infection-log.json | jq .stats.coveredCodeMsi)
    - anybadge -l "Mutation CCMSI" -v $mutation_ccmsi -f mutation_ccmsi.svg 50=red 90=yellow
  artifacts:
    paths:
      - badges/
    when: always
    expire_in: 4 weeks
  only:
    refs:
      - branches
  except:
    variables:
      - $CI_RUN_INFECTION == "false" # Set in GitLab: Settings > CI/CD > Variables
```

Fichier `README.md` :

```markdown
[![Mutation MSI](https://my-gitlab-host-here.zog/authorHere/myRepositoryHere/-/jobs/artifacts/branchNameHere/raw/badges/mutation_msi.svg?job=job:infection-badge)](targetUrlHere)
[![Mutation MCC](https://my-gitlab-host-here.zog/authorHere/myRepositoryHere/-/jobs/artifacts/branchNameHere/raw/badges/mutation_mcc.svg?job=job:infection-badge)](targetUrlHere)
[![Mutation CCMSI](https://my-gitlab-host-here.zog/authorHere/myRepositoryHere/-/jobs/artifacts/branchNameHere/raw/badges/mutation_ccmsi.svg?job=job:infection-badge)](targetUrlHere)
```