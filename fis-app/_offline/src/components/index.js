/* only for building vux.css */
import Style from '../styles/index.vue' // eslint-disable-line

import Swiper from './swiper'
import SwiperItem from './swiper-item'
import Toast from './toast'
import Alert from './alert'
import Confirm from './confirm'
import Dialog from './dialog'
import Scroller from './scroller'
import ViewBox from './view-box'
import Loading from './loading'
import Praise from './praise'
import CardAd from './card-ad'

import { Tab, TabItem } from './tab'

const vux = {
  Tab,
  TabItem,
  Swiper,
  SwiperItem,
  Scroller,
  Toast,
  Alert,
  Confirm,
  Dialog,
  ViewBox,
  Loading,
  Praise,
  CardAd
}

module.exports = vux
