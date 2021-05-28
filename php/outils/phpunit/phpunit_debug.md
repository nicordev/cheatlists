# debug

- `PHPUnit\TextUI\Command::run()` lance les tests ligne 201 :

    ```php
    $result = $runner->doRun($suite, $this->arguments, $exit);
    ```

    `$suite` contient les tests à exécuter