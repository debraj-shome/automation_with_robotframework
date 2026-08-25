*** Variables ***

${browser}              Chrome
${url}                  https://opensource-demo.orangehrmlive.com/web/index.php/auth/login

${VALID_USERNAME}       Admin
${VALID_PASSWORD}       admin123


${INVALID_USERNAME}     Debraj
${INVALID_PASSWORD}     admin1234

${UPPERCASE_PASSWORD}   ADMIN123

${SQL_INJECTION}        ' OR '1'='1

${XSS_PAYLOAD}          <script>alert(Testing Purpose)</script>

${TIMEOUT}              10s
${ACTION_DELAY}         1s