import React, { useEffect } from 'react'
import { useForm, FormProvider, useFormContext } from 'react-hook-form'

export const MyPage: React.VFC = () => {
  const methods = useForm()
  const { register, handleSubmit, setError } = methods
  const onSubmit = (data: any) => {
    console.log(data)
  }

  useEffect(() => {
    setError('fullName', {
      type: 'editProhibited',
      message: 'read only',
    })
    setError('age', {
      type: 'editProhibited',
      message: 'read only',
    })
    setError('address', {
      type: 'editProhibited',
      message: 'read only',
    })
    setError('zipCode', {
      type: 'editProhibited',
      message: 'read only',
    })
  }, [])

  return (
    <FormProvider {...methods}>
      <form onSubmit={handleSubmit(onSubmit)}>
        <label>FirstName</label>
        <input {...register('firstName', { required: true })} />
        <NestedInput />
        <ReadOnlyInput />
        <input type="submit" />
      </form>
    </FormProvider>
  )
}

const NestedInput: React.VFC = () => {
  const methods = useFormContext()

  return (
    <>
      <label>LastName</label>
      <input {...methods.register('lastName')} />
    </>
  )
}

const ReadOnlyInput: React.VFC = () => {
  const methods = useFormContext()
  const { errors } = methods.formState

  return (
    <>
      <label>Full name</label>
      <input
        disabled={errors.fullName && errors.fullName.type === 'editProhibited'}
        {...methods.register('fullName')}
      />
    </>
  )
}
