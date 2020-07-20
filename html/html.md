# HTML

## Formulaires

- Checkbox

    ```html
    <input type="checkbox" id="mapBox" name="mapBox"><label for="mapBox">MapBox</label>
    <input type="checkbox" id="ignMap" name="ignMap"><label for="ignMap">ignMap</label>
    ```

- Select

    ```html
    <select name="layer" id="layer">
        <option value="mapBox">MapBox</option>
        <option value="ignMap" selected="selected">IGN</option>
        <option value="ign25000">IGN 25000</option>
        <option value="ignPhoto">IGN photo</option>
    </select>
    ```