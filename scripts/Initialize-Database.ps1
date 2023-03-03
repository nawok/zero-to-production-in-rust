function Initialize-Database {
    param (
        [String] 
        $DatabaseUser = "postgres",

        [SecureString]
        $DatabasePassword = (ConvertTo-SecureString "password" -AsPlainText),

        [String]
        $DatabaseName = "newsletter",

        [UInt16]
        $DatabasePort = 5432,

        [String]
        $DatabaseHost = "localhost"
    )

    docker run `
        -e POSTGRES_USER=$DatabaseUser `
        -e POSTGRES_PASSWORD=$(ConvertFrom-SecureString -SecureString $DatabasePassword -AsPlainText) `
        -e POSTGRES_DB=$DatabaseName `
        -p ${DatabasePort}:5432 `
        -d postgres `
        postgres -N 1000
}

function Update-Database {
    param (
        [String]
        $DatabaseUser = "postgres",

        [SecureString]
        $DatabasePassword = (ConvertTo-SecureString "password" -AsPlainText),

        [String]
        $DatabaseName = "newsletter",

        [UInt16]
        $DatabasePort = 5432,

        [String]
        $DatabaseHost = "localhost"
    )

    $env:DATABASE_URL = "postgres://${DatabaseUser}:$(ConvertFrom-SecureString -SecureString $DatabasePassword -AsPlainText)@${DatabaseHost}:${DatabasePort}/${DatabaseName}"
    sqlx database create
    sqlx migrate run
}
