import React, { useCallback, useState, useEffect } from 'react'
import { useStripe, useElements, CardElement } from '@stripe/react-stripe-js'
import {
  Button,
  Box,
  FormControl,
  Grid,
  Typography,
  Select,
  MenuItem,
} from '@material-ui/core'
import { useForm, Controller } from 'react-hook-form'
import {
  CustomerPaymentMethod,
  CustomerShippingAddress,
} from '../../domains/customer/models'

type Props = {
  onSubmit: (paymentMethod: any, shippingAddress: any) => void
  customerPaymentMethods: CustomerPaymentMethod[]
  customerShippingAddresses: CustomerShippingAddress[]
}

export const CheckOutForm: React.VFC<Props> = ({
  onSubmit,
  customerPaymentMethods,
  customerShippingAddresses,
}) => {
  const [isReadyStripe, setIsReadyStripe] = useState(false)
  const [selectedPaymentMethodId, setSelectedPaymentMethodId] = useState('')
  const [selectedShippingAddressId, setSelectedShippingAddressId] = useState('')
  const { control, handleSubmit } = useForm()
  const stripe = useStripe()
  const elements = useElements()

  useEffect(() => {
    if (customerPaymentMethods.length > 0) {
      setSelectedPaymentMethodId(customerPaymentMethods[0].payment_method_id)
    }
    if (customerShippingAddresses.length > 0) {
      setSelectedShippingAddressId(customerShippingAddresses[0].id)
    }
  }, [customerPaymentMethods, customerShippingAddresses])

  const onReady = useCallback(() => {
    setIsReadyStripe(true)
  }, [])

  const handleChange = useCallback((event) => {
    setIsReadyStripe(true)
    setSelectedPaymentMethodId(event.target.value)
  }, [])

  const onStripeFormSubmit = async () => {
    const shippingAddress = {
      id: selectedShippingAddressId,
    }
    if (selectedPaymentMethodId !== '') {
      const paymentMethod = {
        id: selectedPaymentMethodId,
        card: {
          brand: '',
          exp_month: '',
          exp_year: '',
        },
      }
      onSubmit(paymentMethod, shippingAddress)
    } else {
      if (!stripe || !elements) {
        return
      }

      const cardElement = elements.getElement(CardElement)
      if (cardElement) {
        const { error, paymentMethod } = await stripe.createPaymentMethod({
          type: 'card',
          card: cardElement,
        })
        if (error) {
          console.log('[error]', error)
        } else {
          onSubmit(paymentMethod, shippingAddress)
        }
      }
    }
  }

  return (
    <>
      <form onSubmit={handleSubmit(onStripeFormSubmit)}>
        <Grid container>
          <Grid item xs={12}>
            <Typography variant="h5">配送先情報:</Typography>
          </Grid>
          <Grid item xs={12}>
            <Box p={2} />
          </Grid>

          {customerShippingAddresses.length > 0 && (
            <>
              <Grid item xs={12}>
                <FormControl fullWidth>
                  <Box p={2}>
                    <Controller
                      name="paymentMethod"
                      control={control}
                      render={({ field }) => (
                        <Select
                          {...field}
                          displayEmpty
                          value={selectedShippingAddressId}
                          onChange={handleChange}
                          label="登録済のクレジットカード"
                        >
                          {customerShippingAddresses.map((shippingAddress) => {
                            return (
                              <MenuItem
                                key={shippingAddress.id}
                                value={shippingAddress.id}
                              >
                                {shippingAddress.full_address}
                              </MenuItem>
                            )
                          })}
                        </Select>
                      )}
                    />
                  </Box>
                </FormControl>
              </Grid>
            </>
          )}
          <Grid item xs={12}>
            <Box p={2} />
          </Grid>
          <Grid item xs={12}>
            <Typography variant="h5">カード情報:</Typography>
          </Grid>
          <Grid item xs={12}>
            <Box p={2} />
          </Grid>

          {customerPaymentMethods.length > 0 && (
            <>
              <Grid item xs={12}>
                <FormControl fullWidth>
                  <Box p={2}>
                    <Controller
                      name="paymentMethod"
                      control={control}
                      render={({ field }) => (
                        <Select
                          {...field}
                          displayEmpty
                          value={selectedPaymentMethodId}
                          onChange={handleChange}
                          label="登録済のクレジットカード"
                        >
                          {customerPaymentMethods.map((paymentMethod) => {
                            return (
                              <MenuItem
                                key={paymentMethod.payment_method_id}
                                value={paymentMethod.payment_method_id}
                              >
                                {paymentMethod.brand}（{paymentMethod.exp_year}
                                年{paymentMethod.exp_month}月）
                              </MenuItem>
                            )
                          })}
                        </Select>
                      )}
                    />
                  </Box>
                </FormControl>
              </Grid>
            </>
          )}
          <Grid item xs={12}>
            <CardElement
              options={{
                style: {
                  base: {
                    fontSize: '16px',
                    color: '#424770',
                    '::placeholder': {
                      color: '#aab7c4',
                    },
                  },
                  invalid: {
                    color: '#9e2146',
                  },
                },
                hidePostalCode: true,
              }}
              onReady={onReady}
            />
          </Grid>
          <Grid item xs={12}>
            <Box p={2} />
          </Grid>
          <Grid item xs={12}>
            <Button
              variant="contained"
              color="primary"
              disabled={!isReadyStripe}
              type="submit"
            >
              注文する
            </Button>
          </Grid>
        </Grid>
      </form>
    </>
  )
}
