import {Header}  from '@presentation/components/Header'
import {Footer} from '@presentation/components/Footer'
import { Outlet } from 'react-router-dom'

export function Layout () {
  return (
    <>
      <Header />
         <Outlet />
      <Footer />
    </>
  )
}
