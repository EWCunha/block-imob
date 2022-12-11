import { Routes, Route } from 'react-router-dom'
import { Layout } from '@main/factories/pages/layout'

import {Home} from '@main/factories/pages/Home'

export function Router() {
  return (
    <Routes>
       <Route path="/" element={<Layout />}>
            <Route path="/" element={<Home />}/>

            <Route path="/register" element={<Home />}/>
            <Route path="/query" element={<Home />}/>
            <Route path="/sale-and-assignment" element={<Home />}/>
            <Route path="/fiis" element={<Home />}/>
       </Route>
    </Routes>
  )
}
