import React from 'react'
import {
  Box,
  Typography,
  Grid,
  OutlinedInput,
  InputLabel,
  makeStyles,
  Button,
} from '@material-ui/core'
import { useForm } from 'react-hook-form'
import { CustomerSignUp } from '../../domains/customer/models'

type Props = {
  label: string
  buttonLabel: string
  onSubmit: (customer: CustomerSignUp) => void
}
export const CustomerForm: React.VFC<Props> = ({
  label,
  buttonLabel,
  onSubmit,
}) => {
  const classes = useStyles({})
  const { register, handleSubmit } = useForm()

  return (
    <>
      <Box p={1}>
        <Typography variant="h5">{label}</Typography>
        <Grid container>
          <form className={classes.form} onSubmit={handleSubmit(onSubmit)}>
            <Grid item xs={12}>
              <InputLabel htmlFor="email">Email</InputLabel>
              <OutlinedInput
                {...register('email', { required: true })}
                fullWidth
              />
            </Grid>

            <Grid item xs={12}>
              <InputLabel htmlFor="password">パスワード</InputLabel>
              <OutlinedInput
                {...register('password', { required: true })}
                fullWidth
                type="password"
              />
            </Grid>
            <Grid item xs={12}>
              <Button variant="contained" color="primary" type="submit">
                {buttonLabel}
              </Button>
            </Grid>
          </form>
        </Grid>
      </Box>
    </>
  )
}

const useStyles = makeStyles((theme) => ({
  form: {
    width: '100%',
  },
}))
