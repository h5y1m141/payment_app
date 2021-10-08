import React, { useState } from 'react'
import { Typography, Box, Tabs, Tab } from '@material-ui/core'
import { TabPanel } from './TabPanel'
import { CustomerSignUp } from '../../domains/customer/models'
import { CustomerForm } from './CustomerForm'

type Props = {
  onSignInCustomer: (customer: CustomerSignUp) => void
  onCreateCustomer: (customer: CustomerSignUp) => void
}
export const SignInRequiredTemplate: React.VFC<Props> = ({
  onSignInCustomer,
  onCreateCustomer,
}) => {
  const handleChange = (event: any, newValue: number) => {
    setValue(newValue)
  }
  const [value, setValue] = useState(0)
  return (
    <>
      <Typography variant="h4">
        商品購入前に会員登録、もしくは、ログインを行う必要があります
      </Typography>
      <Box sx={{ borderBottom: 1, borderColor: 'divider' }}>
        <Tabs
          value={value}
          onChange={handleChange}
          aria-label="basic tabs example"
        >
          <Tab label="新規会員登録" />
          <Tab label="ログイン" />
        </Tabs>
      </Box>
      <TabPanel value={value} index={0}>
        <CustomerForm
          label="新規会員登録"
          buttonLabel="登録する"
          onSubmit={onCreateCustomer}
        />
      </TabPanel>
      <TabPanel value={value} index={1}>
        <CustomerForm
          label="ログイン"
          buttonLabel="ログインする"
          onSubmit={onSignInCustomer}
        />
      </TabPanel>
    </>
  )
}
