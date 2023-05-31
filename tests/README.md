Tests and Coverage
================
31 May, 2023 23:15:11

- <a href="#coverage" id="toc-coverage">Coverage</a>
- <a href="#unit-tests" id="toc-unit-tests">Unit Tests</a>

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                              | Coverage (%) |
|:----------------------------------------------------|:------------:|
| CAIP                                                |    73.11     |
| [R/fct_get_data.R](../R/fct_get_data.R)             |     0.00     |
| [R/fct_plot.R](../R/fct_plot.R)                     |     0.00     |
| [R/run_app.R](../R/run_app.R)                       |     0.00     |
| [R/utils_helpers.R](../R/utils_helpers.R)           |     0.00     |
| [R/mod_downloads.R](../R/mod_downloads.R)           |    64.29     |
| [R/mod_gppt.R](../R/mod_gppt.R)                     |    66.23     |
| [R/golem_utils_server.R](../R/golem_utils_server.R) |    77.78     |
| [R/mod_filters.R](../R/mod_filters.R)               |    81.70     |
| [R/golem_utils_ui.R](../R/golem_utils_ui.R)         |    87.94     |
| [R/app_config.R](../R/app_config.R)                 |    100.00    |
| [R/app_server.R](../R/app_server.R)                 |    100.00    |
| [R/app_ui.R](../R/app_ui.R)                         |    100.00    |
| [R/mod_fft.R](../R/mod_fft.R)                       |    100.00    |
| [R/mod_methodology.R](../R/mod_methodology.R)       |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                            |   n | time | error | failed | skipped | warning | icon |
|:----------------------------------------------------------------|----:|-----:|------:|-------:|--------:|--------:|:-----|
| [test-app.R](testthat/test-app.R)                               |   1 | 0.00 |     0 |      0 |       0 |       0 |      |
| [test-fct_get_data.R](testthat/test-fct_get_data.R)             |   1 | 0.00 |     0 |      0 |       0 |       0 |      |
| [test-fct_helpers.R](testthat/test-fct_helpers.R)               |   1 | 0.00 |     0 |      0 |       0 |       0 |      |
| [test-fct_plot.R](testthat/test-fct_plot.R)                     |   1 | 0.00 |     0 |      0 |       0 |       0 |      |
| [test-golem-recommended.R](testthat/test-golem-recommended.R)   |  10 | 0.10 |     0 |      0 |       1 |       0 | \+   |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R) |  13 | 0.03 |     0 |      0 |       0 |       0 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R)         |  51 | 0.22 |     0 |      0 |       0 |       0 |      |
| [test-mod_downloads.R](testthat/test-mod_downloads.R)           |   2 | 0.00 |     0 |      0 |       0 |       0 |      |
| [test-mod_fft.R](testthat/test-mod_fft.R)                       |   2 | 0.02 |     0 |      0 |       0 |       0 |      |
| [test-mod_filters.R](testthat/test-mod_filters.R)               |   2 | 0.02 |     0 |      0 |       0 |       0 |      |
| [test-mod_gppt.R](testthat/test-mod_gppt.R)                     |   2 | 0.02 |     0 |      0 |       0 |       0 |      |
| [test-mod_methodology.R](testthat/test-mod_methodology.R)       |   2 | 0.02 |     0 |      0 |       0 |       0 |      |
| [test-utils_helpers.R](testthat/test-utils_helpers.R)           |   1 | 0.02 |     0 |      0 |       0 |       0 |      |

<details open>
<summary>
Show Detailed Test Results
</summary>

| file                                                                    | context            | test                           | status  |   n | time | icon |
|:------------------------------------------------------------------------|:-------------------|:-------------------------------|:--------|----:|-----:|:-----|
| [test-app.R](testthat/test-app.R#L2)                                    | app                | multiplication works           | PASS    |   1 | 0.00 |      |
| [test-fct_get_data.R](testthat/test-fct_get_data.R#L2)                  | fct_get_data       | multiplication works           | PASS    |   1 | 0.00 |      |
| [test-fct_helpers.R](testthat/test-fct_helpers.R#L2)                    | fct_helpers        | multiplication works           | PASS    |   1 | 0.00 |      |
| [test-fct_plot.R](testthat/test-fct_plot.R#L2)                          | fct_plot           | multiplication works           | PASS    |   1 | 0.00 |      |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L3)        | golem-recommended  | app ui                         | PASS    |   2 | 0.05 |      |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L13)       | golem-recommended  | app server                     | PASS    |   4 | 0.01 |      |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L24_L26)   | golem-recommended  | app_sys works                  | PASS    |   1 | 0.02 |      |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L36_L42)   | golem-recommended  | golem-config works             | PASS    |   2 | 0.01 |      |
| [test-golem-recommended.R](testthat/test-golem-recommended.R#L71)       | golem-recommended  | app launches                   | SKIPPED |   1 | 0.01 | \+   |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L2)      | golem_utils_server | not_in works                   | PASS    |   2 | 0.00 |      |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L7)      | golem_utils_server | not_null works                 | PASS    |   2 | 0.00 |      |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L12)     | golem_utils_server | not_na works                   | PASS    |   2 | 0.00 |      |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L17_L22) | golem_utils_server | drop_nulls works               | PASS    |   1 | 0.00 |      |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L26_L29) | golem_utils_server | %\|\|% works                   | PASS    |   2 | 0.01 |      |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L37_L40) | golem_utils_server | %\|NA\|% works                 | PASS    |   2 | 0.00 |      |
| [test-golem_utils_server.R](testthat/test-golem_utils_server.R#L48_L50) | golem_utils_server | rv and rvtl work               | PASS    |   2 | 0.02 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L2)              | golem_utils_ui     | Test with_red_star works       | PASS    |   2 | 0.00 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L10)             | golem_utils_ui     | Test list_to_li works          | PASS    |   3 | 0.02 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L22_L28)         | golem_utils_ui     | Test list_to_p works           | PASS    |   3 | 0.01 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L53)             | golem_utils_ui     | Test named_to_li works         | PASS    |   3 | 0.02 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L66)             | golem_utils_ui     | Test tagRemoveAttributes works | PASS    |   4 | 0.01 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L82)             | golem_utils_ui     | Test undisplay works           | PASS    |   8 | 0.03 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L110)            | golem_utils_ui     | Test display works             | PASS    |   4 | 0.02 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L124)            | golem_utils_ui     | Test jq_hide works             | PASS    |   2 | 0.00 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L132)            | golem_utils_ui     | Test rep_br works              | PASS    |   2 | 0.02 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L140)            | golem_utils_ui     | Test enurl works               | PASS    |   2 | 0.01 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L148)            | golem_utils_ui     | Test columns wrappers works    | PASS    |  16 | 0.06 |      |
| [test-golem_utils_ui.R](testthat/test-golem_utils_ui.R#L172)            | golem_utils_ui     | Test make_action_button works  | PASS    |   2 | 0.02 |      |
| [test-mod_downloads.R](testthat/test-mod_downloads.R#L32)               | mod_downloads      | module ui works                | PASS    |   2 | 0.00 |      |
| [test-mod_fft.R](testthat/test-mod_fft.R#L32)                           | mod_fft            | module ui works                | PASS    |   2 | 0.02 |      |
| [test-mod_filters.R](testthat/test-mod_filters.R#L32)                   | mod_filters        | module ui works                | PASS    |   2 | 0.02 |      |
| [test-mod_gppt.R](testthat/test-mod_gppt.R#L32)                         | mod_gppt           | module ui works                | PASS    |   2 | 0.02 |      |
| [test-mod_methodology.R](testthat/test-mod_methodology.R#L32)           | mod_methodology    | module ui works                | PASS    |   2 | 0.02 |      |
| [test-utils_helpers.R](testthat/test-utils_helpers.R#L2)                | utils_helpers      | multiplication works           | PASS    |   1 | 0.02 |      |

| Failed | Warning | Skipped |
|:-------|:--------|:--------|
| !      | \-      | \+      |

</details>
<details>
<summary>
Session Info
</summary>

| Field    | Value                             |
|:---------|:----------------------------------|
| Version  | R version 4.3.0 (2023-04-21 ucrt) |
| Platform | x86_64-w64-mingw32/x64 (64-bit)   |
| Running  | Windows 10 x64 (build 19045)      |
| Language | English_United Kingdom            |
| Timezone | Europe/London                     |

| Package  | Version |
|:---------|:--------|
| testthat | 3.1.8   |
| covr     | 3.6.2   |
| covrpage | 0.2     |

</details>
<!--- Final Status : skipped/warning --->
