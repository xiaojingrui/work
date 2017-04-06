import { getInfo } from './app'

let localCookie = `idfa=0DBB1298-09AC-47E4-89DD-2D1FD91D5BC2; _inKanqiuApp=1; __dacevid3=0x805669d54a7c7263; _gamesu=MTkwNDM2ODI=|MTQ4MjIyMTgxNw==|83b747b0b6335938ff1fd0dc91f6e627; u=26012356|dGVzdF9CZWt0dQ==|4e79|1a88a552e7c83f03678df2263ea7b441|e7c83f03678df226|UmF5bGVlOTI2; ua=26003891`
export default () => {
    let env = getInfo().env
    let cookie = getInfo().cookies
    let header = env == 1 ? cookie : (cookie || localCookie)
    return {
        header: header
    }
}
