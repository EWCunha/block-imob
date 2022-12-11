import { createGlobalStyle } from 'styled-components'

export const GlobalStyle = createGlobalStyle`
  *{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  :focus{
    outline: 0;
  }

  body{
    font-family: "Poppins";
    font-weight: 400;
    background: url('/background.svg');
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
  }

  .mySwiper{
    display: flex;
    height: 680px;
    flex-direction: row-reverse;
  }
  .swiper-wrapper {
    height: 100%;
    width: unset;
  }

 .swiper-pagination-vertical.swiper-pagination-bullets, .swiper-vertical>.swiper-pagination-bullets {
    position: relative;
    height: 100%;
    justify-content: center;
    align-items: center;
    display: flex;
    flex-direction: column;
    margin-right: 38px;
    width: unset;
    right: 0 !important;
  }

  .swiper-pagination-bullet {
    background: #FFFFFF;
    opacity: 0.4;
  }

  .swiper-pagination-bullet-active {
    background: #FFFFFF !important;
    opacity: 1 !important;
  }

  .swiper-slide{
    height: 680px;
    margin-bottom: 30px;
    display: flex;
    flex-direction: column;
    align-items: start;
    justify-content: center;
  }

`
