import React from 'react'
import { Box } from '@material-ui/core'

type Props = {
  value: number
  index: number
  children: React.ReactNode
}
export const TabPanel: React.VFC<Props> = ({ value, index, children }) => {
  return (
    <div
      role="tabpanel"
      hidden={value !== index}
      id={`simple-tabpanel-${index}`}
      aria-labelledby={`simple-tab-${index}`}
    >
      {value === index && <Box sx={{ p: 3 }}>{children}</Box>}
    </div>
  )
}
