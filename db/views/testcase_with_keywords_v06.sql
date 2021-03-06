SELECT  testcases.id, testcases.project_id, testcases.name, testcases.validation_id, testcases.updated_at, testcases.version, testcases.token, testcases.outdated, testcases.revised_at, testcases.created_at, array_agg(keywords.keyword) as keywords FROM "testcases"
  LEFT OUTER JOIN keywords_testcases ON keywords_testcases.testcase_id = testcases.id
  LEFT OUTER JOIN keywords ON keywords_testcases.keyword_id = keywords.id
GROUP BY testcases.id, testcases.project_id, testcases.name, testcases.validation_id, testcases.updated_at, testcases.version, testcases.token, testcases.outdated, testcases.revised_at, testcases.created_at
