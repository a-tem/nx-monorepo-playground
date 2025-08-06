import styled from '@emotion/styled';

const StyledTitle = styled.div`
  color: #ff8800;
`;

interface TitleProps {
  title: string;
}

export const Title: React.FC<TitleProps> = ({ title }) => {
  return (
    <StyledTitle>
      <h1>{title}</h1>
    </StyledTitle>
  );
};

export default Title;
